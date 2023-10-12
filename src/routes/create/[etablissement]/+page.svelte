<script lang="ts">
	import type { PageData } from './$types';
	import { page } from '$app/stores';
	import { onMount } from 'svelte';
	import type { TDocumentDefinitions } from 'pdfmake/interfaces';

	export let data: PageData;
	let base_url = '';
	page.subscribe((pageData) => {
		base_url = pageData.url.origin;
		console.log('Base URL:', base_url);  // Debug log
	});

	let qrCodeUrls: string[] = [];
	let qrCodeImages: string[] = [];

	for (let i = 1; i < 5; i++) {
		qrCodeUrls.push(`https://workshop-i1-dev.up.railway.app/${data.establishment}/${i}`);
	}

	const generateQRCode = async (url: string): Promise<string> => {
		console.log('Generating QR code for URL:', url);  // Debug log
		const response = await fetch(
			`https://api.qrserver.com/v1/create-qr-code/?data=${url}&size=300x300`
		);
		if (response.ok) {
			const blob = await response.blob();
			return new Promise<string>((resolve) => {
				const reader = new FileReader();
				reader.readAsDataURL(blob);
				reader.onloadend = function () {
					const base64data = reader.result;
					qrCodeImages.push(base64data as string);
					resolve(base64data as string);
				};
			});
		} else {
			throw new Error('Failed to generate QR code');
		}
	};

	let pdfLink: string = '';

	onMount(async () => {
		console.log('Component mounted. Generating QR codes...');  // Debug log

		// Ensure all QR codes are generated
		await Promise.all(qrCodeUrls.map((url) => generateQRCode(url)));

		console.log('All QR codes generated. Now generating PDF...');  // Debug log

		const pdfmake = await import('pdfmake/build/pdfmake.js');
		const fonts = await import('pdfmake/build/vfs_fonts.js');

		pdfmake.vfs = fonts.pdfMake.vfs;

		const docDefinition: TDocumentDefinitions = {
			content: qrCodeImages.map((image) => ({
				image,
				width: 300,
				alignment: 'center',
				margin: [0, 300]
			})),
			pageSize: 'A4'
		};

		const pdfDocGenerator = pdfmake.createPdf(docDefinition);
		pdfDocGenerator.getDataUrl((dataUrl: string) => {
			pdfLink = dataUrl;
		});
	});
</script>

<div class="container grid grid-cols-3 gap-4 mt-8">
	<h3 class="col-span-3 mb-4">QR CODES</h3>
	{#each qrCodeUrls as url, index}
		<div class="flex flex-col items-center">
			<p>Question n°{index+1}</p>
			{#await generateQRCode(url)}
				<p>Loading qr code</p>
			{:then image}
				<img src={image} alt="url" class="w-32 h-32 mb-2" />
				<a href={image} download class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600"
					>Download</a
				>
			{/await}
		</div>
	{/each}
	<!-- Button to download the entire PDF -->
	<a
		href={pdfLink}
		download="QRCodes.pdf"
		class="mt-4 bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">Download All as PDF</a
	>
</div>
