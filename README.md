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

```
PUT /index1
{
  "settings": {
    "index": {
      "number_of_shards": 2,  
      "number_of_replicas": 1 
    }
  }
}

PUT /index2
{
  "settings": {
    "index": {
      "number_of_shards": 1,  
      "number_of_replicas": 1 
    }
  }
}
```

![Image depicting shards and replicas](https://miro.medium.com/max/4800/1*H7gHSye6qQNEargkRz01og.png)

### Type (Legacy after 7.0.0)
- Like a table in a DB (not necessary in every case though)
- An index say poi can have sub types, poi_us, poi_jp, poi_uk etc.
- Each type can have a mapping, although same name fields need to have same data type
- Querying can be done on specific types in an index
- For eg: ```GET poi/poi_us/123```

### Mapping
- Like a schema of a table
- Which field to consider as text/keyword/integer/geo_point
- Affects how data is indexed and queried
- Not necessary to be provided, ElasticSearch tries to identify based on value
- ```GET poi_us/_mapping```
```
PUT my_index 
{
  "mappings": {
    "_doc": { 
      "properties": { 
        "title":    { "type": "text"  }, 
        "name":     { "type": "text"  }, 
        "age":      { "type": "integer" },  
        "created":  {
          "type":   "date", 
          "format": "strict_date_optional_time||epoch_millis"
        }
      }
    }
  }
}
```

### Document
- JSON objects that are stored within an Elasticsearch index
- Base unit of storage
- Can be compared to a row in a Relational table
- Has metadata fields starting with '_'
- ```GET <index>/<type>/<doc_id>```, eg: ```GET /accounts/person/1```
```
{
    "_index": "accounts",
    "_type": "person",
    "_id": "1",
    "_version": 1,
    "found": true,
    "_source": {
        "name": "John",
        "lastname": "Doe",
        "job_description": "Systems administrator and Linux specialit"
    }
}
```

### Fields
- Smallest individual unit of data in Elasticsearch
- Each field has a defined datatype and contains a single piece of data
- Core datatypes (strings, numbers, dates, booleans)
- Complex datatypes (object and nested)
- Geo datatypes (get_point and geo_shape)
- Specialized datatypes (token count, join, rank feature, dense vector, flattened, etc.)
- In the above example of mapping, `title`, `name`, `age`, `created_at` are all fields.

### Analyzers
- Used during indexing and querying to break down – or parse – phrases and expressions into their constituent terms
- Can be specified per-query, per-field or per-index
- Consists of a single tokenizer and any number of token filters
- By default, Elasticsearch will apply the Standard Analyzer, which contains a grammar-based tokenizer that removes common English words and applies additional filters
- For instance, the string `The quick Brown Foxes.` may, depending on which analyzer is used, be analyzed to the tokens: `quick`, `brown`, `fox`
- These are the actual terms that are indexed for the field, which makes it possible to search efficiently for individual words within big blobs of text.
```
PUT /my_index
{
  "mappings": {
    "properties": {
      "text": { 
        "type": "text",
        "fields": {
          "english": { 
            "type":     "text",
            "analyzer": "english"
          }
        }
      }
    }
  }
}

GET my_index/_analyze 
{
  "field": "text",
  "text": "The quick Brown Foxes."
}

GET my_index/_analyze 
{
  "field": "text.english",
  "text": "The quick Brown Foxes."
}
```
```
The text field uses the default standard analyzer`.


The text.english multi-field uses the english analyzer, which removes stop words and applies stemming.


This returns the tokens: [ the, quick, brown, foxes ].


This returns the tokens: [ quick, brown, fox ].
```
## Demo Operations

### Index document(s)
- Create a mapping
```
PUT /shakespeare
{
 "mappings": {
   "properties": {
    "speaker": {"type": "keyword"},
    "play_name": {"type": "text"},
    "line_id": {"type": "integer"},
    "speech_number": {"type": "integer"}
   }
  }
}
```
- Index shakespeare plays data
  - Download json data from here: [link](https://download.elastic.co/demos/kibana/gettingstarted/shakespeare_6.0.json)
  - Bulk index using this command: ```curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9500/shakespeare/_bulk?pretty' --data-binary @shakespeare_6.0.json```
### Search documents
- Search in the shakespeare plays 
```
GET shakespeare/_search
{
    "query": {
      "match_all": {}
    }
}

GET shakespeare/_search/
{
  "query":{
    "match" : {
      "play_name" : "Henry IV"
    }
  }
}

GET shakespeare/_search/
{
  "query":{
    "query_string": {
      "default_field": "play_name",
      "query": "*Antony*"
    }
  }
}
```

## References
1. https://www.elastic.co/blog/a-practical-introduction-to-elasticsearch
2. https://logz.io/blog/10-elasticsearch-concepts/
3. https://medium.com/velotio-perspectives/elasticsearch-101-fundamentals-core-components-a1fdc6090a5e
4. http://www.lucenetutorial.com/basic-concepts.html
