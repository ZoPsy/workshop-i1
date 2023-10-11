<script lang="ts">
	const etablissement = '1';

	export { etablissement };
</script>

<div class="main-container">
	<div class="content-container">
		<h1 class="h2">Nom du projet</h1>
		<form class="card p-6 rounded-lg flex flex-col gap-8" action="?/submit" method="POST">
			<label class="label">
				<input
					class="input"
					name="name"
					id="name"
					type="text"
					placeholder="Entre le nom de ton entreprise"
				/>
			</label>
			<button type="submit" class="btn variant-filled">Confirmer</button>
		</form>
	</div>
</div>
