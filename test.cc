#pragma once
#define LOG(message) logError(__LINE__, message)
#pragma STDC FP_CONTRACT
_Pragma(yep)
#undef __cplusplus
#include <iostream>
#include "foo/bar.h"

constexpr double pi = 3.14;

// hello

/* world */

thread_local int neat = 1;

[[deprecated("asdasd")]] int *f() noexcept {
  synchronized { printf("transaction"); }
  return nullptr;
};

alignas(128) char cacheline[128];

template <typename... Args>
bool print_size(Args... args)
{
  cout << sizeof...(args) << endl;
  return true;
}

decltype(int) other_integer_variable = 5++;

template <class T> concept bool Integral = std::is_integral<T>::value;

struct A final : Base {
  [[maybe_unused]]
  virtual void foo() final;
};
