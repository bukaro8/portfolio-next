import Image from "next/image";
import Link from "next/link";

const Introduction = () => {
  return (
    <div className="z-20 w-full bg-darkBg/60">
      <div className="z-20 grid items-center h-full p-6 py-20 md:py-0 md:grid-cols-2">
        <Image
          src="/home-4.png"
          priority
          width={800}
          height={800}
          alt="Victor Ramirez avatar illustration"
        />

        <div className="flex flex-col justify-center max-w-md">
          <h1 className="mb-5 text-2xl leading-tight text-center md:text-left md:text-4xl md:mb-10">
            If you can imagine it, <br />
            <span className="font-bold text-secondary">you can build it</span>
          </h1>

          <p className="mx-auto mb-2 text-xl md:text-xl md:mx-0 md:mb-8">
            I’m Victor Ramirez — a London-based full-stack developer focused on
            React, TypeScript, and Node. I care about clean design, performance,
            and accessibility to create impactful digital experiences.
          </p>

          <div className="flex items-center justify-center gap-3 md:justify-start md:gap-10">
            <Link
              href="/portfolio"
              className="px-3 py-2 my-2 transition-all border-2 cursor-pointer text-md w-fit rounded-xl hover:shadow-xl hover:shadow-white/50"
            >
              View projects
            </Link>
            <Link
              href="/contact"
              className="px-3 py-2 my-5 transition-all border-2 cursor-pointer text-md w-fit text-secondary border-secondary rounded-xl hover:shadow-xl hover:shadow-secondary"
            >
              Contact me
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Introduction;
