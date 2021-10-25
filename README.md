# Elasticsearch Hands on Session

## What is !ElasticSearch?
- Not for primary data storage
- Not an SQL DB, no support for
  - Transactions
  - Sub-queries
  - Joins

## What is ElasticSearch?
- It's a software/service/tool to do fast textual search
- Wrapper written in JAVA over **Lucene** (understatement)
- Interface through a REST API
- May look like a NoSQL DB
  - Stores data in JSON documents


## What's Lucene?
- Full-text search library in Java
- Inverted Index
  - Lucene is able to achieve fast search responses because, instead of searching the text directly, it searches an index instead. This would be the equivalent of retrieving pages in a book related to a keyword by searching the index at the back of a book, as opposed to searching the words in each page of the book.
  - This type of index is called an inverted index, because it inverts a page-centric data structure (page->words) to a keyword-centric data structure (word->pages).
  - ![Image explaining Inverted Index](https://i.stack.imgur.com/5yyY2.png)


## Why or When to use ElasticSearch?
- When you have a lot of text-based data and want to provide keyword based search.
- To add search functionality in a website. Think search bars in amazon/zomato/<insert any e-commerce platform here>
- Sift through your partners chat data, to find out whom they are flirting with? 😜😉

## Install ElasticSearch
- Using docker here
- Can be standalone
- Requires JAVA

## Install Kibana
- Using Docker here
- Can be standalone
- Requires JAVA
- Need to be compatible with ES version

## Run ElasticSearch and Kibana
- `make run`

## Connect to running cluster with Kibana
- Will happen automatically using docker compose file
- Can use environment variables or kibana.yml for configuring `ELASTICSEARCH_HOSTS`

## Important Basic terms/concepts

### Cluster
- Health API

### Nodes
- Master
- Data
- Co-ordinating only Node

### Index
- 

### Shards
- 

### Replicas
- 

### Type
- 

### Mapping
- 

### Document
- 

### Fields
- 

### Analyzers
- 

## Operations

### Index document(s)
### Search documents
### Update document(s)

## References
1. https://www.elastic.co/blog/a-practical-introduction-to-elasticsearch
2. https://logz.io/blog/10-elasticsearch-concepts/
3. https://medium.com/velotio-perspectives/elasticsearch-101-fundamentals-core-components-a1fdc6090a5e
4. http://www.lucenetutorial.com/basic-concepts.html
