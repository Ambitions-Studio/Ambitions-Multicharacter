/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        'ambitions': {
          'primary': '#1e293b',     // slate-800
          'secondary': '#374151',   // gray-700
          'accent': '#60a5fa',      // blue-400
        }
      }
    },
  },
  plugins: [],
  corePlugins: {
    preflight: false,
  },
}

