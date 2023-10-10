<script lang="ts">
	import Scanner from '$lib/components/Scanner.svelte';

	const etablissement = '1';

	export { etablissement };
</script>

<div class="main-container">
	<div class="content-container">
		<h1 class="h2">Let's get cracking bones!</h1>
		<form class="card p-6 rounded-lg flex flex-col gap-8" action="" method="post">
			<label class="label">
				<input class="input" type="text" placeholder="Entre le nom de ton entreprise" />
			</label>
			<button type="button" class="btn variant-filled">Confirmer</button>
		</form>
	</div>
</div>
