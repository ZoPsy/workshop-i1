<script lang="ts">
	import type { PageData } from './$types';

	let data: PageData;

	export { data };
</script>

<div class="main-container">
	<div class="content-container">
		<div class="card p-3 text-center">
			<h1 class="h2 text-2xl">Bravo tu as terminé ta formation 🎉</h1>
			<span>Score : {data.score}</span>
		</div>
		<div class="flex flex-col gap-5">
			<a href="/{data.etablissement}" type="button" class="btn variant-filled"
				>Revenir sur la page principale</a
			>
			<a href="/{data.etablissement}/leaderboard" type="button" class="btn variant-ghost">
				<span><img src="/assets/stats.svg" alt="graphique" /></span>
				<span>Leaderboard</span>
			</a>
		</div>
	</div>
</div>
