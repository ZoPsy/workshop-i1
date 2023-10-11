<script lang="ts">
	import type { PageData } from './$types';
	import { page } from '$app/stores';
	import QRCode from '@castlenine/svelte-qrcode';

	export let data: PageData;
	let base_url = '';
	page.subscribe((pageData) => {
		base_url = pageData.url.origin;
	});

    let qrCodes: = []
</script>

<div class="container">
	<QRCode content="https://workshop-i1-production.up.railway.app/epsi/1" />
</div>
