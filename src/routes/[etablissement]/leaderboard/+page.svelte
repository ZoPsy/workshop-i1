<script lang="ts">
	import { Table, tableMapperValues, type TableSource } from '@skeletonlabs/skeleton';
	import type { PageData } from './$types';

	//export let data: PageData;

	let data: PageData;

	/* const sourceData = [
		{ position: 1, name: 'Hydrogen', score: 1 },
		{ position: 2, name: 'Helium', score: 4 },
		{ position: 3, name: 'Lithium', score: 6 },
		{ position: 4, name: 'Beryllium', score: 9 },
		{ position: 5, name: 'Boron', score: 10 }
	]; */

	const sourceData = data.sourceData
		.filter((user) => user.score !== null)
		.map((user, index: number) => {
			return { position: index + 1, name: user.name, score: user.score ? user.score : '0' };
		});

	const tableSimple: TableSource = {
		// A list of heading labels.
		head: ['Position', 'Nom', 'Score'],
		// The data visibly shown in your table body UI.
		body: tableMapperValues(sourceData, ['position', 'name', 'score']),
		// Optional: The data returned when interactive is enabled and a row is clicked.
		meta: tableMapperValues(sourceData, ['position', 'name', 'score'])
		// Optional: A list of footer labels.
	};

	export { tableSimple, Table, data };
</script>

<div class="main-container">
	<div class="content-container">
		<h1 class="h2">Leaderboard</h1>
		<div class="flex flex-col gap-5">
			<a href="/{data.etablissement}" type="button" class="btn variant-ghost">Retour</a>
			<Table source={tableSimple} />
		</div>
	</div>
</div>
