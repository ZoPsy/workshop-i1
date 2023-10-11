<script lang="ts">
	import { fade } from 'svelte/transition';
	import type { ActionData, PageData } from './$types';
	import { getToastStore } from '@skeletonlabs/skeleton';

	export let data: PageData;
	export let form: ActionData;
	const toastStore = getToastStore();

	$: {
        console.log(form?.exists)
		if (form?.exists === true) {
			toastStore.trigger({
				message: 'Ce nom existe déjà',
				background: 'variant-filled-error'
			});
		}
	}
</script>

<div class="main-container">
	<div class="content-container">
		<div class="flex flex-col gap-5">
			<form method="POST" action="?/new">
				<span>Nom de l'établissement ou entreprise</span>
				<div class="flex flex-row space-x-2">
					<input
						class="input w-11/12"
						title="Nom de l'établissement ou entreprise"
                        name="name"
						type="text"
						placeholder="Ministère de l'intérieur"
						value={form?.name ?? ''}
					/>
				</div>
			</form>
		</div>
	</div>
</div>
