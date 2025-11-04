/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'export',            // enables `next export`
  images: { unoptimized: true }, // required for next/image on static export
  trailingSlash: true          // avoids some 404s on deep links
};
module.exports = nextConfig;
