package data

import (
	"database/sql"
	"fmt"
	"sync"
	"testing"
)

func TestUpdate(t *testing.T) {
	db, _ := sql.Open("postgres", "postgres://greenlight:pa55word@localhost/greenlight?sslmode=disable")
	defer db.Close()
	wg := &sync.WaitGroup{}
	mm := NewModels(db)
	m, _ := mm.Movies.Get(4)
	for i := 0; i < 25; i++ {
		wg.Add(1)
		go func() {
			err := mm.Movies.Update(m)
			fmt.Println(err)
			wg.Done()
		}()
	}
	wg.Wait()
}
