import { defineConfig } from "vite";

export default defineConfig({
  root: ".", // Root directory (default is the current directory)
  server: {
    port: 3000, // Custom port (default is 5173)
    hot: true, // Ensure HMR is enabled
    watch: {
      usePolling: true,
    },
  },
});
