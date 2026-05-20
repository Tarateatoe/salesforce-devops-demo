import { LightningElement, api } from 'lwc';

export default class DocumentViewer extends LightningElement {
    @api title;
    @api description;
    @api githubUrl;
    @api markdownContent;
    @api createdDate = '2026-05-20';
    @api lastUpdated = '2026-05-20';

    handlePrint() {
        window.print();
    }

    handleDownload() {
        // Create a blob from the markdown content
        const blob = new Blob([this.markdownContent || 'Content not available'], { type: 'text/markdown' });
        const url = window.URL.createObjectURL(blob);

        // Create temporary link and trigger download
        const link = document.createElement('a');
        link.href = url;
        link.download = `${this.title.replace(/\s+/g, '_')}.md`;
        document.body.appendChild(link);
        link.click();

        // Cleanup
        document.body.removeChild(link);
        window.URL.revokeObjectURL(url);
    }

    handleGitHub() {
        if (this.githubUrl) {
            window.open(this.githubUrl, '_blank');
        }
    }
}
