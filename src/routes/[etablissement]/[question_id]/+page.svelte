<script lang="ts">
	import { slide } from 'svelte/transition';
	import type { PageData } from './$types';
	import { goto } from '$app/navigation';

	let isIntro = true;

	let isFinished = false;
	let score = 4;

	//export let data: PageData;
	let data: PageData;

	let isClicked: boolean[] = [];
	data.answers.forEach(() => {
		isClicked.push(false);
	});

	export { isIntro, data, isClicked, score };
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
					{#each data.answers as answer, index}
						<button
							type="button"
							class="btn {!isClicked[index]
								? 'variant-ghost'
								: answer.is_correct
								? 'variant-filled-success'
								: 'variant-filled-error'}"
							on:click={(evt) => {
								if (answer.is_correct) {
									isFinished = true;
								}
								if (!isClicked[index] && !answer.is_correct) {
									score--;
								}
								isClicked[index] = true;
							}}>{answer.answer_text}</button
						>
					{/each}
				</div>
				<div class="flex gap-5 w-full">
					<form action="?/submit" method="POST">
						<input class="hidden" type="text" id="username" name="username" value="{data.username}" />
						<button
							type="submit"
							id="btn"
							name="btn"
							value="{score}"
							class="btn variant-filled {isFinished ? 'opacity-100' : 'opacity-50 pointer-events-none'}"
							>Continuer</button
						>
					</form>
					<button on:click={() => (isIntro = true)} type="button" class="btn variant-filled-surface"
						>Retour</button
					>
				</div>
			</div>
		</div>
	{/if}
</div>
