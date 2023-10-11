<script lang="ts">
	const etablissement = '1';

	import logo from '$lib/assets/logo.svg';

	console.log(logo);

	export { etablissement };
</script>

<div class="main-container">
	<div class="content-container">
		<h1 class="h2">QR Chase</h1>
		<div class="flex flex-row justify-center items-center">
			<div class=" bg-gray-300 rounded-3xl w-8/12 md:w-10/12">
				<img alt="The project logo" src={logo} />
			</div>
		</div>
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
