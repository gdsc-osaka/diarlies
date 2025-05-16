export type ForUpdate<T extends { id: unknown }> = Pick<T, "id"> &
  Partial<Omit<T, "id">>;
