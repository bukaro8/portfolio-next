// next.config.js
/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'export',         // <- required to generate /out with `next build`
  images: { unoptimized: true }, // if you use next/image
};
export default nextConfig;
