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

<div class="main-container">
	<div class="content-container">
		<h3 class="h2 mb-4">QR CODES</h3>
		<div class="flex flex-row justify-center items-center flex-wrap gap-4">
			{#each qrCodeUrls as url, index}
				<div class="flex flex-col items-center bg-gray-300 rounded-3xl p-4 space-y-4">
					<p class="text-black">Question n°{index+1}</p>
					{#await generateQRCode(url)}
						<p>Loading qr code</p>
					{:then image}
						<img src={image} alt="url" class="w-32 h-32 mb-2 rounded-md" />
						<a href={image} download class="btn variant-filled mt-2">Download</a>
					{/await}
				</div>
			{/each}
		</div>
		<!-- Button to download the entire PDF -->
		<a
			href={pdfLink}
			download="QRCodes.pdf"
			class="btn variant-filled mt-4">Download All as PDF</a
		>
	</div>
</div>
