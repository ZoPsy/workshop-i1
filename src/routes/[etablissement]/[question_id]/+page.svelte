<script lang="ts">
	import { slide } from 'svelte/transition';
	import type { PageData } from './$types';
	import { goto } from '$app/navigation';

	let isIntro = true;

	let isAnswerCorrect = false;

	$: {
		if (isAnswerCorrect == true) {
			goto(`${data.question.number}/scanner`);
		}
	}

	//export let data: PageData;
	let data: PageData;
	export { isIntro, data };
</script>

<div class="main-container">
	{#if isIntro}
		<div class="content-container">
			<div class="flex flex-col gap-10 items-center">
				<span>Scénario N°{data.question.number}</span>
				<div class="card p-4">
					<p>
						{data.question.explanation}
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
				<span>Scénario N°{data.question.number}</span>
				<span>{data.question.explanation}</span>
				<div class="flex flex-col gap-5 w-full">
					{#each data.answers as answer}
						<button
							type="button"
							class="btn variant-ghost"
							on:click={() => {
								isAnswerCorrect = answer.is_correct;
							}}>{answer.answer_text}</button
						>
					{/each}
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
