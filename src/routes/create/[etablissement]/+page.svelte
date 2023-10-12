<script lang="ts">
	import type { PageData } from './$types';
	import { page } from '$app/stores';
	import { onMount } from 'svelte';

	export let data: PageData;
	let base_url = '';
	page.subscribe((pageData) => {
		base_url = pageData.url.origin;
	});

	let qrCodeUrls: string[] = [];
	let qrCodeImages: string[] = [];

	for (let i = 1; i < 5; i++) {
		qrCodeUrls.push(`https://workshop-i1-production.up.railway.app/${data.establishment}/${i}`);
	}
	console.log(qrCodeUrls)

	const generateQRCode = async (url: string) => {
		const response = await fetch(
			`https://api.qrserver.com/v1/create-qr-code/?data=${url}&size=300x300`
		);
		if (response.ok) {
			const blob = await response.blob();
			const imageUrl = URL.createObjectURL(blob);
			return imageUrl;
		}
	};
</script>

<div class="container grid grid-cols-3 gap-4 mt-8">
	<h3 class="col-span-3 mb-4">QR CODES</h3>
	{#each qrCodeUrls as url}
		<div class="flex flex-col items-center">
			{#await generateQRCode(url)}
				<p>Loading qr code</p>
			{:then image} 
				<img src="{image}" alt="url" class="w-32 h-32 mb-2">
				<a href="{image}" download class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Download</a>
			{/await}
		</div>
	{/each}
</div>
