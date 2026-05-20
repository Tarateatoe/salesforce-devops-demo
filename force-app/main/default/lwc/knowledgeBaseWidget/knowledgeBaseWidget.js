import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

export default class KnowledgeBaseWidget extends LightningElement {
    @api recordId;
    @api objectApiName;

    searchTerm = '';
    articles = [];
    isLoading = false;

    handleSearchChange(event) {
        this.searchTerm = event.target.value;
    }

    handleSearch() {
        this.isLoading = true;
        // Search logic will be implemented with Knowledge API
        console.log('Searching for:', this.searchTerm);
        this.isLoading = false;
    }

    get hasArticles() {
        return this.articles && this.articles.length > 0;
    }
}
