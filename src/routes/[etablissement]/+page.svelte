<script lang="ts">
	import type { PageData } from './$types';

	export let data: PageData;
</script>

<div class="main-container">
	<div class="content-container">
		<h1 class="h2">Let's get cracking bones!</h1>
		<div class="flex flex-col gap-5">
			<p class="text-10">{data.etablissement}</p>
			<a href="/1/1" type="button" class="btn variant-filled">Démarrer</a>
			<a href="/1/leaderboard" type="button" class="btn variant-ghost">
				<span><img src="/assets/stats.svg" alt="graphique" /></span>
				<span>Leaderboard</span>
			</a>
		</div>
	</div>
</div>
