import { DATABASE_URL } from '$env/static/private';
import type { Handle } from '@sveltejs/kit';
import postgres from 'postgres';

export const handle: Handle = async ({ event, resolve }) => {

    const sql = postgres(DATABASE_URL);

    event.locals = {
        sql: sql
    };

    const response = await resolve(event);
    return response;
};