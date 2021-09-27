export function reduceErrors(errors) {
    if (!Array.isArray(errors)) {
        errors = [errors];
    }

    return (
        errors
            .filter((error) => !!error) // Delete null/undefined items
            .map((error) => { // Extract error message
                if (Array.isArray(error.body)) { // UI API read errors
                    return error.body.map((e) => e.message);
                }
                else if (error.body && typeof error.body.message === 'string') {
                    return error.body.message; // UI API DML, Apex and network errors
                }
                else if (typeof error.message === 'string') {
                    return error.message; // JS errors
                }
                return error.statusText; // Unknown error HTTP status text
            })
            .reduce((prev, curr) => prev.concat(curr), []) // Flatten
            .filter((message) => !!message) // Remove empty strings
    );
}