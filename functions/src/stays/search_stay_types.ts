export type StaySearchRequest = {
  city?: unknown;
  checkIn?: unknown;
  checkOut?: unknown;
  adults?: unknown;
  children?: unknown;
  minPrice?: unknown;
  maxPrice?: unknown;
  minimumRating?: unknown;
  categoryIds?: unknown;
  collectionIds?: unknown;
  amenities?: unknown;
  inventoryType?: unknown;
  cursor?: unknown;
  pageSize?: unknown;
};

export type StaySearchFilters = {
  city: string | null;
  checkIn: Date | null;
  checkOut: Date | null;
  adults: number;
  children: number;
  minPrice: number;
  maxPrice: number;
  minimumRating: number;
  categoryIds: string[];
  collectionIds: string[];
  amenities: string[];
  inventoryType: "singleUnit" | "multipleUnits" | null;
  cursor: string | null;
  pageSize: number;
};

export type StayDocument = {
  id: string;
  data: Record<string, unknown>;
};

export type StayCursor = {
  id: string;
  averageRating: number;
  reviewCount: number;
  name: string;
};
