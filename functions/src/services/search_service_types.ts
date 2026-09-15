export type ServiceSearchRequest = {
  date?: unknown;
  timeMinutes?: unknown;
  categoryId?: unknown;
  collectionId?: unknown;
  city?: unknown;
  minPrice?: unknown;
  maxPrice?: unknown;
  sortOption?: unknown;
  cursor?: unknown;
  pageSize?: unknown;
};

export type ServiceSearchFilters = {
  date: Date | null;
  timeMinutes: number | null;
  categoryId: string | null;
  collectionId: string | null;
  city: string | null;
  minPrice: number;
  maxPrice: number;
  sortOption: string;
  cursor: string | null;
  pageSize: number;
};

export type ServiceDocument = {
  id: string;
  data: Record<string, unknown>;
};
