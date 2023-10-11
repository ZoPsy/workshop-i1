<script lang="ts">
	import { slide } from 'svelte/transition';
	import type { PageData } from './$types';

	const scenario = 1;
	let isIntro = true;

	//export let data: PageData;
	let data: PageData;
	export { isIntro, data };
</script>

<div class="main-container">
	{#if isIntro}
		<div class="content-container">
			<div class="flex flex-col gap-10 items-center">
				<span>Scénario N°{data.question.number}</span>
				<span>Titre</span>
				<div class="card p-4">
					<p>
						{data.question.question_text}
					</p>
				</div>
				<button on:click={() => (isIntro = false)} type="button" class="btn variant-filled"
					>Continuer</button
				>
			</div>
		</div>
	{:else}
		<div in:slide={{ duration: 300, axis: 'x' }} class="content-container">
			<div class="flex flex-col gap-10 items-center">
				<span>Scénario N°{data.question.number} sur 4</span>
				<span>Question</span>
				<div class="flex flex-col gap-5 w-full">
					<button type="button" class="btn variant-ghost">Réponse 1</button>
					<button type="button" class="btn variant-ghost">Réponse 2</button>
					<button type="button" class="btn variant-ghost">Réponse 3</button>
					<button type="button" class="btn variant-ghost">Réponse 4</button>
				</div>
				<div class="flex gap-5 w-full">
					<button type="button" class="btn variant-filled">Continuer</button>
					<button on:click={() => (isIntro = true)} type="button" class="btn variant-filled-surface"
						>Retour</button
					>
				</div>
			</div>
		</div>
	{/if}
</div>
