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
- To add search functionality in a website. Think search bars in amazon/zomato/--insert any e-commerce platform here--
- Sift through your partner's chat data, to find out whom they are flirting with? 😜😉

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
- One or more servers collectively providing indexing and search capabilities form an Elasticsearch cluster.
- Health API: ```GET _cluster/health```
  - Green: All shards are allocated
  - Yellow: Primary shard is allocated but replicas are not 
  - Red: Primary shard is not allocated in the cluster

### Nodes
- Single physical or virtual machine that holds full or part of your data and provides computing power for indexing and searching
- Identified with a unique name
- Cluster will be formed automatically with all the nodes having the same `cluster.name` at startup
- Types:
  - Master
    - Administrator of the cluster
    - Think of as a manager, making sure cluster is healthy and stable using certain operations
    - Only certain master-eligible nodes become master nodes
    - Election happens among nodes
  - Data
    - Stores data
    - Takes part in indexing, searching, aggregation etc
    - Every node is by default data node
  - Co-ordinating only Node
    - Any node, which is not a master node or a data node, is a coordinating node
    - Smart load balancers, redirects requests between data nodes and master nodes.
    - Exposed to end-user requests
  - ![Image showing diff nodes](https://miro.medium.com/max/4800/1*sNjkqZOFsCA4cf_jQQbgJQ.png)
  - Nodes list API: ```GET _nodes```

### Index
- Largest unit of data in Elasticsearch
- Logical partitions of documents
- Can be compared to a database in the world of relational databases (not necessary true for every case)
- Index List API ```GET /_cat/indices?v```
- Create an Index ```PUT /<index>```
- Delete an Index ```DELETE /<index>```

### Shards
- Subset of an Index
- Allows horizontal scalability of a cluster
- Takes part in searching
- Configurable through API
- List Shards ```GET /_shard_stores``` or ```GET <index>/_shard_stores```

### Replicas
- Copies of your index’s shards
- Backup system for a rainy day
- Replicas also serve read requests, so adding replicas can help to increase search performance
- To ensure high availability, replicas are not placed on the same node as the original shards (called the “primary” shard) from which they were replicated
- Configurable through API
- Can be checked using any index stats api or shards api as well
- ```GET _cat/indices?v``` or ```GET <index>/_shard_stores```

![Image depicting shards and replicas](https://miro.medium.com/max/4800/1*H7gHSye6qQNEargkRz01og.png)

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
