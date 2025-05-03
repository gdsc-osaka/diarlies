import { defineConfig } from 'vitest/config';

export default defineConfig({
  define: {
    'import.meta.vitest': false,
  },
  test: {
    globals: true,
    include: ['test/**/*.test.ts'],
  },
});
