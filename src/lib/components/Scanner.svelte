<script lang="ts">
	import { onMount, onDestroy } from 'svelte';
	import { Html5Qrcode, Html5QrcodeScanner } from 'html5-qrcode';

	let qrCodeScanner: Html5Qrcode;

	function onScanSuccess(decodedText: any, decodedResult: any) {
		// handle the scanned code as you like, for example:
		console.log(`Code matched = ${decodedText}`, decodedResult);
	}

	function onScanFailure(error: any) {
		// handle scan failure, usually better to ignore and keep scanning.
		// for example:
		console.warn(`Code scan error = ${error}`);
	}

	let html5QrcodeScanner = new Html5QrcodeScanner(
		'reader',
		{ fps: 10, qrbox: { width: 250, height: 250 } },
		/* verbose= */ false
	);
	onMount(() => {
		html5QrcodeScanner.render(onScanSuccess, onScanFailure);
	});

	onDestroy(() => {
		if (qrCodeScanner) {
			qrCodeScanner.stop();
		}
	});
</script>

<div id="reader" class=" w-3/4" />
