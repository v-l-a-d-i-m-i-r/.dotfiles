package main

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"strconv"
	"strings"
	"sync"
)

type Result struct {
	Name string
}

type Page struct {
	Count   int
	Results []Result
}

func fetchPage(namespace string, repository string, page int, perPage int) Page {
  base, err := url.Parse("https://hub.docker.com")

	if err != nil {
		fmt.Println(err)
	}

  // Path params
  base.Path += "/v2/namespaces/" + namespace + "/repositories/" + repository + "/tags"
  // Query params
  params := url.Values{}
  params.Add("page", strconv.FormatInt(int64(page), 10))
  params.Add("page_count", strconv.FormatInt(int64(perPage), 10))
  base.RawQuery = params.Encode()

	res, err := http.Get(base.String())

	if err != nil {
		fmt.Println(err)
	}

	defer res.Body.Close()

	body, err := io.ReadAll(res.Body)

	if err != nil {
		fmt.Println(err)
	}

	var pageStruct Page
	json.Unmarshal(body, &pageStruct)

  return pageStruct
}

func getTagsFromPage(page Page) []string {
  tags := make([]string, len(page.Results))

  for i, result := range page.Results {
    tags[i] = result.Name
  }

  return tags
}

func main() {
  perPage := 100
  namespace := "library"
  repository := "node"

  firstPage := fetchPage(namespace, repository, 1, perPage)
  // pagesCount := firstPage.Count / perPage
  pagesCount := 2
  if (firstPage.Count % perPage) != 0 {
    pagesCount += 1
  }
  firstPageTags := getTagsFromPage(firstPage)
  if pagesCount > 1 {
    tagsChan := make(chan string)
    var wg sync.WaitGroup
    wg.Add(pagesCount - 1)

    for i := 2; i < pagesCount; i++ {
      go func (j int) {
        defer wg.Done()

        page := fetchPage(namespace, repository, j, perPage)
        pageTags := getTagsFromPage(page)

        tagsChan <- pageTags[0]
        // for _, tag := range pageTags {
        //   fmt.Println(tag)
        //   tagsChan <-tag
        // }
      } (i)
    }

    wg.Wait()

    close(tagsChan)
    for tag := range tagsChan {
      fmt.Println(tag)
    }
    // fmt.Println(<- tagsChan)
  }
  // resultsChan := make(chan string)
  fmt.Println(firstPage.Count)
  fmt.Println(strings.Join(firstPageTags, "\n"))
  
}
