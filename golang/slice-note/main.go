package main

import "fmt"

func main() {
	//case1append()
	//case2append()
}

func case1append()()  {
	arr := []int{1,2}
	fmt.Printf("%p\n", arr)  // 0xc00001a090
	fmt.Printf("%p\n", &arr) // 0xc00000c080
	fmt.Println(len(arr), cap(arr)) // 2 2
	case1(arr)
	fmt.Println(arr)
}

func case1(arr []int)  {
	fmt.Printf("%p\n", arr) // 0xc00001a090
	fmt.Printf("%p\n", &arr) // 0xc00000c0c0

	arr = append(arr, 3)
	fmt.Printf("%p\n", arr) // 0xc000018160
	fmt.Printf("%p\n", &arr) // 0xc00000c0c0
}

func case2append()  {
	arr := []int{1,2}
	fmt.Printf("%p\n", arr)  // 0xc00001a090
	fmt.Printf("%p\n", &arr) // 0xc00000c080
	fmt.Println(len(arr), cap(arr)) // 2 2
	case2(&arr)
	fmt.Println(arr)
}


func case2(arr *[]int)  {
	fmt.Printf("%p\n", arr)  // 0xc00000c080
	fmt.Printf("%p\n", &arr) // 0xc00000e030
	fmt.Printf("%p\n", *arr) // 0xc00001a090

	*arr = append(*arr, 3)
	fmt.Printf("%p\n", arr)  // 0xc00000c080
	fmt.Printf("%p\n", &arr) // 0xc00000e030
	fmt.Printf("%p\n", *arr) // 0xc000018160
}

