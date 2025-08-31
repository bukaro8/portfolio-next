import type { Metadata } from 'next';
import Link from 'next/link';

import TransitionPage from '@/components/transition-page';
import ContainerPage from '@/components/container-page';

export const metadata: Metadata = {
	title: 'Thank you | Victor Ramirez',
	robots: { index: false, follow: false },
};

export default function ThankYouPage() {
	return (
		<>
			<TransitionPage />
			<ContainerPage>
				<main className='min-h-[70vh] flex items-start justify-center p-6 bg-transparent'>
					<div className='max-w-md text-center'>
						<h1 className='text-3xl md:text-4xl font-bold'>
							Thanks! <span className='text-secondary'>Message sent</span>
						</h1>
						<p className='mt-4 opacity-80'>
							I’ll get back to you as soon as possible. If it’s urgent, feel
							free to reach out on my socials.
						</p>

						<div className='mt-8 flex items-center justify-center gap-3'>
							<Link
								href='/'
								className='px-5 py-3 rounded-2xl border-2 border-secondary hover:shadow-xl hover:shadow-secondary transition'
							>
								Back to Home
							</Link>
							<Link
								href='/portfolio'
								className='px-5 py-3 rounded-2xl border-2 border-white/30 hover:shadow-xl hover:shadow-white/40 transition'
							>
								View Projects
							</Link>
						</div>
					</div>
				</main>
			</ContainerPage>
		</>
	);
}
