// next.config.js
/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'export',                 // creates /out
  images: { unoptimized: true },    // if you're using next/image
  trailingSlash: false,             // keep clean URLs
};
module.exports = nextConfig;
