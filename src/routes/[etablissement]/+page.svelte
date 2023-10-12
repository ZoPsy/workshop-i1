<script lang="ts">
	import { tweened } from 'svelte/motion';
	import type { ActionData, PageData } from './$types';
	import { generateUsername } from 'unique-username-generator';
	import { cubicOut } from 'svelte/easing';
	import { goto } from '$app/navigation';

	//const username = generateUsername('-');

	let data: PageData;
	export let form: ActionData;

	let spin = false;
	const rotation = tweened(0, { duration: 1000, easing: cubicOut });

	$: if (spin) {
		rotation.set(360).then(() => {
			spin = false;
			rotation.set(0);
		});
		const input: HTMLInputElement | null = document.querySelector('#username');
		if (input !== null) {
			const newUsername = generateUsername('-');
			input.value = newUsername;
		}
	}

	export { data };
</script>

<div class="main-container">
	<div class="content-container">
		<h1 class="h2 uppercase">{data.etablissement.name}</h1>
		<div class="flex flex-col gap-5">
			<form id="userForm" method="POST" action="?/checkUser">
				<label class="label">
					<span>Pseudonyme (unique)</span>
					<div class="flex flex-row space-x-2">
						<input
							class="input w-11/12"
							title="Username"
							id="username"
							name="username"
							type="text"
							placeholder="John Doe"
							value={''}
						/>
						<button
							type="button"
							on:click={() => {
								spin = true;
							}}
							class="w-1/12 h-auto btn-icon variant-filled"
						>
							<svg
								xmlns="http://www.w3.org/2000/svg"
								fill="none"
								viewBox="0 0 24 24"
								stroke-width="1.5"
								stroke="currentColor"
								class="w-6 h-6"
								style="transform: rotate({$rotation}deg);"
							>
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									d="M16.023 9.348h4.992v-.001M2.985 19.644v-4.992m0 0h4.992m-4.993 0l3.181 3.183a8.25 8.25 0 0013.803-3.7M4.031 9.865a8.25 8.25 0 0113.803-3.7l3.181 3.182m0-4.991v4.99"
								/>
							</svg>
						</button>
					</div>
				</label>
				<button
					type="submit"
					on:click={() => goto(`/${data.etablissement.name}/1`)}
					class="btn variant-filled w-full mt-5">Démarrer</button
				>
			</form>
			<button
				on:click={() => goto(`/${data.etablissement.name}/leaderboard`)}
				class="btn variant-ghost"
			>
				<span><img src="/assets/stats.svg" alt="graphique" /></span>
				<span>Leaderboard</span>
			</button>
		</div>
	</div>
</div>
