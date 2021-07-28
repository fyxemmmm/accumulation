package main

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
	"math/rand"
	"net/http"
)

var (
	cpuTemp = prometheus.NewGauge(prometheus.GaugeOpts{
		Name: "cpu_temperature_celsius",
		Help: "Current temperature of the CPU.",
	})
	hdFailures = prometheus.NewCounterVec(
		prometheus.CounterOpts{
			Name: "hd_errors_total",
			Help: "Number of hard-disk errors.",
		},
		[]string{"device"},
	)
	r = prometheus.NewRegistry()
)

func init() {
	r.MustRegister(cpuTemp)
	r.MustRegister(hdFailures)
}

func exampleUseGin()  {
	r := gin.Default()
	r.GET("/metrics", gin.WrapH(promhttp.Handler()))
	r.Run(":8081")
}

func main() {
	go exampleUseGin()

	mux := http.NewServeMux()
	mux.Handle("/metrics", promhttp.HandlerFor(r, promhttp.HandlerOpts{}))
	mux.Handle("/metrics2", promhttp.Handler()) // go的自身指标

	mux.HandleFunc("/incr", func(writer http.ResponseWriter, request *http.Request) {
		hdFailures.WithLabelValues("/dev/sda").Inc()
	})

	mux.HandleFunc("/random", func(writer http.ResponseWriter, request *http.Request) {
		random := rand.Int() % 10
		fmt.Println(random)
		cpuTemp.Set(float64(random))
	})

	httpServer := &http.Server{
		Addr:              ":8080",
		Handler:           mux,
	}
	httpServer.ListenAndServe()
}
