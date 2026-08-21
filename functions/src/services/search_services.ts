import { getFirestore } from "firebase-admin/firestore";
import { HttpsError, onCall } from "firebase-functions/v2/https";

import { filterServicesWithAvailability } from "./search_service_availability.js";
import { loadServiceCandidates } from "./search_service_documents.js";
import {
  matchesServiceFilters,
  parseServiceSearchFilters,
} from "./search_service_filters.js";
import { pageServices, sortServices } from "./search_service_response.js";
import type { ServiceSearchRequest } from "./search_service_types.js";

export const searchServices = onCall<ServiceSearchRequest>(
  { region: "us-central1" },
  async (request) => {
    if (request.auth == null) {
      throw new HttpsError(
        "unauthenticated",
        "You need to sign in to search services.",
      );
    }

    try {
      const filters = parseServiceSearchFilters(request.data);
      const database = getFirestore();
      const candidates = await loadServiceCandidates(database, filters);
      const staticMatches = candidates.filter((service) =>
        matchesServiceFilters(service, filters),
      );
      const availableServices = await filterServicesWithAvailability(
        database,
        staticMatches,
        filters,
      );

      sortServices(availableServices, filters.sortOption);
      return pageServices(availableServices, filters.cursor, filters.pageSize);
    } catch (error) {
      console.error("[searchServices] Request failed.", error);
      if (error instanceof HttpsError) throw error;
      throw new HttpsError(
        "internal",
        "Unable to search services. Please try again.",
      );
    }
  },
);
