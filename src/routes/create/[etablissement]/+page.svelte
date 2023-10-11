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

	for (let i = 0; i < 4; i++) {
		qrCodeUrls.push(`https://workshop-i1-production.up.railway.app/${data.establishment}/${i}`);
	}

	const generateQRCode = async (url: string) => {
		const response = await fetch(
			`https://api.qrserver.com/v1/create-qr-code/?data=${encodeURIComponent(url)}&size=150x150`
		);
		if (response.ok) {
			const blob = await response.blob();
			const imageUrl = URL.createObjectURL(blob);
			qrCodeImages.push(imageUrl);
		}
	};

	onMount(() => {
		qrCodeUrls.forEach((url) => generateQRCode(url));
	});
</script>

<div class="container">
	{#each qrCodeImages as qrCodeImage, index}
		<div class="qr-item">
			<img src={qrCodeImage} alt="QR Code" />
			<a href={qrCodeImage} download={`QRCode_${index + 1}.png`}>Download QR Code {index + 1}</a>
		</div>
	{/each}
</div>
