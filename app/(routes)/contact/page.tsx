import { Avatar } from '@/components/avatar';
import ContainerPage from '@/components/container-page';

import TransitionPage from '@/components/transition-page';

export default function ContactPage() {
	return (
		<>
			<TransitionPage />
			<ContainerPage>
				<Avatar />
				<main className='flex items-start justify-center  bg-transparent'>
					<form
						action='https://api.web3forms.com/submit'
						method='POST'
						className='w-full max-w-xl space-y-4 p-6 rounded-2xl '
					>
						{/* REQUIRED: your Web3Forms access key */}
						<input
							type='hidden'
							name='access_key'
							value='052a2bc3-9e83-4749-a29f-60f669d38cb7'
						/>

						{/* Optional: Redirect after success */}
						<input
							type='hidden'
							name='redirect'
							value='https://www.vicdeveloper.co.uk/thank-you'
						/>

						{/* Anti-spam honeypot (leave hidden) */}
						<input
							type='checkbox'
							name='botcheck'
							tabIndex={-1}
							className='hidden'
							aria-hidden='true'
						/>

						<h1 className='text-3xl font-bold'>
							Contact <span className='text-secondary'>Me</span>
						</h1>

						<div className='grid gap-4 md:grid-cols-2'>
							<div>
								<label className='block mb-1 text-sm'>Name</label>
								<input
									type='text'
									name='name'
									required
									className='w-full rounded-xl bg-white/80 text-black p-3 outline-none'
									placeholder='Your name'
								/>
							</div>
							<div>
								<label className='block mb-1 text-sm'>Email</label>
								<input
									type='email'
									name='email'
									required
									className='w-full rounded-xl bg-white/80 text-black p-3 outline-none'
									placeholder='you@example.com'
								/>
							</div>
						</div>

						<div>
							<label className='block mb-1 text-sm'>Subject</label>
							<input
								type='text'
								name='subject'
								className='w-full rounded-xl bg-white/80 text-black p-3 outline-none'
								placeholder='How can I help?'
							/>
						</div>

						<div>
							<label className='block mb-1 text-sm'>Message</label>
							<textarea
								name='message'
								required
								rows={6}
								className='w-full rounded-xl bg-white/80 text-black p-3 outline-none'
								placeholder='Write your message…'
							/>
						</div>

						<button
							type='submit'
							className='px-5 py-3 rounded-2xl border-2 border-secondary hover:shadow-xl hover:shadow-secondary transition'
						>
							Send message
						</button>
					</form>
				</main>
			</ContainerPage>
		</>
	);
}
