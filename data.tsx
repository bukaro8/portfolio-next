import {
	CodeSquare,
	HomeIcon,
	UserRound,
	Linkedin,
	Twitter,
	Github,
	Mail,
} from 'lucide-react';

export const socialNetworks = [
	{
		id: 1,
		logo: <Github size={30} strokeWidth={1} />,
		src: 'https://github.com/bukaro8/',
	},
	{
		id: 2,
		logo: <Linkedin size={30} strokeWidth={1} />,
		src: 'https://www.linkedin.com/in/victor-ramirez-developer/',
	},
	{
		id: 3,
		logo: <Twitter size={30} strokeWidth={1} />,
		src: 'https://x.com/bukaro83',
	},
];

export const itemsNavbar = [
	{
		id: 1,
		title: 'Home',
		icon: <HomeIcon size={25} color='#fff' strokeWidth={1} />,
		link: '/',
	},
	{
		id: 2,
		title: 'User',
		icon: <UserRound size={25} color='#fff' strokeWidth={1} />,
		link: '/about-me',
	},
	{
		id: 3,
		title: 'Target',
		icon: <CodeSquare size={25} color='#fff' strokeWidth={1} />,
		link: '/portfolio',
	},
	{
		id: 4,
		title: 'Mail',
		icon: <Mail size={25} color='#fff' strokeWidth={1} />,
		link: '/contact',
	},
];

export const dataAboutPage = [
	{
		id: 1,
		title: 'Web Developer (Internship)',
		subtitle: 'IPS Central',
		description:
			'Worked as a web developer intern using React, Redux, Node.js, Express and MongoDB. Contributed to building and maintaining web applications, improving performance, and collaborating with the team in an Agile environment.',
		date: '06/2022',
	},
	{
		id: 2,
		title: 'Full Stack Developer (Bootcamp Project)',
		subtitle: 'Henry Bootcamp',
		description:
			'Built a full-stack e-commerce application using React, Redux, Node.js, Express, PostgreSQL, and MongoDB. Designed RESTful APIs, integrated databases, and deployed with Vercel and Railway.',
		date: '01/2022',
	},
	{
		id: 3,
		title: 'Bootcamp Trainee',
		subtitle: 'QA Ltd',
		description:
			'Completed QA Bootcamp training in Digital & Cloud fundamentals, gaining hands-on experience with modern web technologies and industry practices.',
		date: '01/2023',
	},
	{
		id: 4,
		title: 'Web Development Diploma (Ongoing)',
		subtitle: 'Code Institute / NESCOT College',
		description:
			'Currently studying a Level 5 Diploma in Web Development, deepening my knowledge of software engineering, full-stack development and industry standards.',
		date: '09/2024',
	},
];

export const dataPortfolio = [
	{
		id: 1,
		title: 'SettleUP',
		image: '/image-1.png',
		urlGithub: 'https://github.com/bukaro8/settleUp',
		urlDemo: 'https://settle-up-tap.netlify.app/',
	},
	{
		id: 2,
		title: 'Brewers Notes',
		image: '/image-2.png',
		urlGithub: 'https://github.com/bukaro8/brewnotes',
		urlDemo: 'https://brewnotes.art',
	},
	{
		id: 3,
		title: 'IPS La Central',
		image: '/image-3.png',
		urlGithub: 'https://github.com/bukaro8/ips-la-central',
		urlDemo: 'https://www.ipslacentral.com/',
	},
];
