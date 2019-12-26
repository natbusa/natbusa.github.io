{
  "cells": [
    {
      "cell_type": "code",
      "execution_count": 1,
      "metadata": {},
      "outputs": [],
      "source": [
        "import datafaucet as dfc"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "Datafaucet is a productivity framework for ETL, ML application. Simplifying some of the common activities which are typical in Data pipeline such as project scaffolding, data ingesting, start schema generation, forecasting etc."
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "## Loading and Saving Parquet Data"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 2,
      "metadata": {},
      "outputs": [
        {
          "name": "stdout",
          "output_type": "stream",
          "text": [
            " [datafaucet] NOTICE parquet.ipynb:engine:__init__ | Connecting to spark master: local[*]\n",
            " [datafaucet] NOTICE parquet.ipynb:engine:__init__ | Engine context spark:2.4.4 successfully started\n"
          ]
        },
        {
          "data": {
            "text/plain": [
              "<datafaucet.project.Project at 0x7f6e3bfe9630>"
            ]
          },
          "execution_count": 2,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "dfc.project.load('minimal')"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 3,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/plain": [
              "profile: minimal\n",
              "variables: {}\n",
              "engine:\n",
              "    type: spark\n",
              "    master: local[*]\n",
              "    jobname:\n",
              "    timezone: naive\n",
              "    submit:\n",
              "        jars: []\n",
              "        packages: []\n",
              "        pyfiles:\n",
              "        files:\n",
              "        repositories:\n",
              "        conf:\n",
              "providers:\n",
              "    local:\n",
              "        service: file\n",
              "        path: data\n",
              "resources: {}\n",
              "logging:\n",
              "    level: info\n",
              "    stdout: true\n",
              "    file: datafaucet.log\n",
              "    kafka: []"
            ]
          },
          "execution_count": 3,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "dfc.metadata.profile()"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "### Filter and projections Filters push down on parquet files\n",
        "\n",
        "The following show how to selectively read files on parquet files (with partitions)"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "#### Create data"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 4,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>g</th>\n",
              "      <th>id</th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <td>0</td>\n",
              "      <td>0</td>\n",
              "      <td>2504</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>1</td>\n",
              "      <td>1</td>\n",
              "      <td>2320</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>2</td>\n",
              "      <td>3</td>\n",
              "      <td>2640</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>3</td>\n",
              "      <td>2</td>\n",
              "      <td>2536</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "   g    id\n",
              "0  0  2504\n",
              "1  1  2320\n",
              "2  3  2640\n",
              "3  2  2536"
            ]
          },
          "execution_count": 4,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "df = dfc.range(10000).cols.create('g').randchoice([0,1,2,3])\n",
        "df.cols.groupby('g').agg('count').data.grid()"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "#### Save data as parquet objects"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 5,
      "metadata": {},
      "outputs": [
        {
          "name": "stdout",
          "output_type": "stream",
          "text": [
            " [datafaucet] INFO parquet.ipynb:engine:save_log | save\n"
          ]
        }
      ],
      "source": [
        "df.repartition('g').save('local', 'groups.parquet');"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 6,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/html": [
              "<div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>name</th>\n",
              "      <th>type</th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <td>0</td>\n",
              "      <td>g=2</td>\n",
              "      <td>DIRECTORY</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>1</td>\n",
              "      <td>g=1</td>\n",
              "      <td>DIRECTORY</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>2</td>\n",
              "      <td>g=3</td>\n",
              "      <td>DIRECTORY</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>3</td>\n",
              "      <td>g=0</td>\n",
              "      <td>DIRECTORY</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>4</td>\n",
              "      <td>_SUCCESS</td>\n",
              "      <td>FILE</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <td>5</td>\n",
              "      <td>._SUCCESS.crc</td>\n",
              "      <td>FILE</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>"
            ],
            "text/plain": [
              "            name       type\n",
              "0            g=2  DIRECTORY\n",
              "1            g=1  DIRECTORY\n",
              "2            g=3  DIRECTORY\n",
              "3            g=0  DIRECTORY\n",
              "4       _SUCCESS       FILE\n",
              "5  ._SUCCESS.crc       FILE"
            ]
          },
          "execution_count": 6,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "dfc.list('data/save/groups.parquet').data.grid()"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "#### Read data parquet objects (with pushdown filters)"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 7,
      "metadata": {},
      "outputs": [],
      "source": [
        "spark = dfc.engine().context"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 8,
      "metadata": {},
      "outputs": [
        {
          "name": "stdout",
          "output_type": "stream",
          "text": [
            " [datafaucet] INFO parquet.ipynb:engine:load_log | load\n"
          ]
        }
      ],
      "source": [
        "df = dfc.load('data/save/groups.parquet')"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 9,
      "metadata": {},
      "outputs": [
        {
          "name": "stdout",
          "output_type": "stream",
          "text": [
            "== Physical Plan ==\n",
            "*(1) FileScan parquet [id#91L,g#92] Batched: true, Format: Parquet, Location: InMemoryFileIndex[file:/home/natbusa/Projects/datafaucet/examples/tutorial/data/save/groups.parquet], PartitionCount: 4, PartitionFilters: [], PushedFilters: [], ReadSchema: struct<id:bigint>\n"
          ]
        }
      ],
      "source": [
        "df.explain()"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 10,
      "metadata": {},
      "outputs": [],
      "source": [
        "def explainSource(obj):\n",
        "    for s in obj._jdf.queryExecution().simpleString().split('\\n'):\n",
        "        if 'FileScan' in s:\n",
        "            params = [\n",
        "                'Batched', \n",
        "                'Format', \n",
        "                'Location',\n",
        "                'PartitionCount', \n",
        "                'PartitionFilters', \n",
        "                'PushedFilters',\n",
        "                'ReadSchema']\n",
        "            \n",
        "            # (partial) parse the Filescan string\n",
        "            res = {}\n",
        "            # preamble\n",
        "            first, _, rest = s.partition(f'{params[0]}:')\n",
        "            # loop\n",
        "            for i in range(len(params[1:])):\n",
        "                first, _, rest = rest.partition(f'{params[i+1]}:')\n",
        "                res[params[i]]=first[1:-2]\n",
        "            # store last\n",
        "            res[params[-1]]=rest[1:]\n",
        "            \n",
        "            # hide location data, not relevant here\n",
        "            del res['Location']\n",
        "            \n",
        "            return dfc.yaml.YamlDict(res)"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 11,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/plain": [
              "Batched: 'true'\n",
              "Format: Parquet\n",
              "PartitionCount: '4'\n",
              "PartitionFilters: '[]'\n",
              "PushedFilters: '[]'\n",
              "ReadSchema: struct<id:bigint>"
            ]
          },
          "execution_count": 11,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "### No pushdown on the physical plan\n",
        "\n",
        "explainSource(df)"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 12,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/plain": [
              "Batched: 'true'\n",
              "Format: Parquet\n",
              "PartitionCount: '4'\n",
              "PartitionFilters: '[]'\n",
              "PushedFilters: '[]'\n",
              "ReadSchema: struct<>"
            ]
          },
          "execution_count": 12,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "### Pushdown only column selection\n",
        "res = df.groupby('g').count()\n",
        "explainSource(res)"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 13,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/plain": [
              "Batched: 'true'\n",
              "Format: Parquet\n",
              "PartitionCount: '4'\n",
              "PartitionFilters: '[]'\n",
              "PushedFilters: '[IsNotNull(id), GreaterThan(id,100)]'\n",
              "ReadSchema: struct<id:bigint>"
            ]
          },
          "execution_count": 13,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "# push down row filter only but take all partitions\n",
        "res = df.filter('id>100')\n",
        "explainSource(res)"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 14,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/plain": [
              "Batched: 'true'\n",
              "Format: Parquet\n",
              "PartitionCount: '1'\n",
              "PartitionFilters: '[isnotnull(g#92), (g#92 = 1)]'\n",
              "PushedFilters: '[IsNotNull(id), GreaterThan(id,100)]'\n",
              "ReadSchema: struct<id:bigint>"
            ]
          },
          "execution_count": 14,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "# pushdown partition filters and row (columnar) filters\n",
        "res = df.filter('id>100 and g=1').groupby('g').count()\n",
        "explainSource(res)"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 15,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/plain": [
              "Batched: 'true'\n",
              "Format: Parquet\n",
              "PartitionCount: '2'\n",
              "PartitionFilters: '[((g#92 = 2) || (g#92 = 3))]'\n",
              "PushedFilters: '[IsNotNull(id), GreaterThan(id,100)]'\n",
              "ReadSchema: struct<id:bigint>"
            ]
          },
          "execution_count": 15,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "# pushdown partition filters and row (columnar) filters\n",
        "res = df.filter('id>100 and (g=2 or g=3)').groupby('g').count()\n",
        "explainSource(res)"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 16,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/plain": [
              "Batched: 'true'\n",
              "Format: Parquet\n",
              "PartitionCount: '2'\n",
              "PartitionFilters: '[isnotnull(g#92), (g#92 > 1)]'\n",
              "PushedFilters: '[IsNotNull(id), GreaterThan(id,100)]'\n",
              "ReadSchema: struct<id:bigint>"
            ]
          },
          "execution_count": 16,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "# pushdown partition filters and row (columnar) filters\n",
        "res = df.filter('id>100 and g>1').groupby('g').count()\n",
        "explainSource(res)"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 17,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/plain": [
              "Batched: 'true'\n",
              "Format: Parquet\n",
              "PartitionCount: '1'\n",
              "PartitionFilters: '[isnotnull(g#92), (g#92 > 1), (g#92 = 2)]'\n",
              "PushedFilters: '[IsNotNull(id), GreaterThan(id,100), LessThan(id,500)]'\n",
              "ReadSchema: struct<id:bigint>"
            ]
          },
          "execution_count": 17,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "# pushdown partition filters and row (columnar) filters can be added up\n",
        "res = df.filter('id>100 and g>1').filter('id<500 and g=2').groupby('g').count()\n",
        "explainSource(res)"
      ]
    },
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        "### When pushdown filters are NOT applied.\n",
        "\n",
        "#### Avoid caching and actions of read data \n",
        "Avoid cache(), count() or other action on data, as they will act as a \"wall\" for filter operations to be pushed down the parquet reader. On the contrary, registering the dataframe as a temorary table is OK. Please be aware that these operation could be hidden in your function call stack, so be always sure that the filters are as close as possible to the read operation.\n",
        "\n",
        "#### Spark will only read the same data once per session\n",
        "Once a parquet file has been read in a cached/unfiltered way, any subsequent read operation will fail to push down the filters, as spark assumes that the data has already been loaded once."
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 18,
      "metadata": {},
      "outputs": [
        {
          "name": "stdout",
          "output_type": "stream",
          "text": [
            " [datafaucet] INFO parquet.ipynb:engine:load_log | load\n"
          ]
        },
        {
          "data": {
            "text/plain": [
              "DataFrame[id: bigint, g: int]"
            ]
          },
          "execution_count": 18,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "df = dfc.load('data/save/groups.parquet')\n",
        "df.cache()"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 19,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/plain": [
              "Batched: 'true'\n",
              "Format: Parquet\n",
              "PartitionCount: '4'\n",
              "PartitionFilters: '[]'\n",
              "PushedFilters: '[]'\n",
              "ReadSchema: struct<id:bigint>"
            ]
          },
          "execution_count": 19,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "# pushdown partition filters and row (columnar) filters are ignored after cache, count, and the like\n",
        "res = df.filter('id>100 and g=1').groupby('g').count()\n",
        "explainSource(res)"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 20,
      "metadata": {},
      "outputs": [
        {
          "name": "stdout",
          "output_type": "stream",
          "text": [
            " [datafaucet] INFO parquet.ipynb:engine:load_log | load\n"
          ]
        }
      ],
      "source": [
        "# re-read will not push down the filters ...\n",
        "df = dfc.load('data/save/groups.parquet')"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 21,
      "metadata": {},
      "outputs": [
        {
          "data": {
            "text/plain": [
              "Batched: 'true'\n",
              "Format: Parquet\n",
              "PartitionCount: '4'\n",
              "PartitionFilters: '[]'\n",
              "PushedFilters: '[]'\n",
              "ReadSchema: struct<id:bigint>"
            ]
          },
          "execution_count": 21,
          "metadata": {},
          "output_type": "execute_result"
        }
      ],
      "source": [
        "# pushdown partition filters and row (columnar) filters are ignored after cache, count, and the like\n",
        "res = df.filter('id>100 and g=1').groupby('g').count()\n",
        "explainSource(res)"
      ]
    }
  ],
  "metadata": {
    "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
    },
    "language_info": {
      "codemirror_mode": {
        "name": "ipython",
        "version": 3
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3",
      "version": "3.7.3"
    }
  },
  "nbformat": 4,
  "nbformat_minor": 4
}
