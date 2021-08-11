package main

import (
	"encoding/json"
	"fmt"
	"github.com/lestrrat-go/jwx/jwk"
	"io/ioutil"
	"log"
	"os"
)

func pubKey() []byte{
	f,_:=os.Open("./mypub.pem")
	b,_:=ioutil.ReadAll(f)

	return  b
}
func main() {

	key, err := jwk.ParseKey(pubKey(),jwk.WithPEM(true))
	if err != nil {
		log.Fatal(err)
	}

	if pubKey, ok := key.(jwk.RSAPublicKey); ok {

		 b,err:=json.Marshal(pubKey)
		if err != nil {
			log.Fatal(err)
		}
		 fmt.Println(string(b))

	}


}