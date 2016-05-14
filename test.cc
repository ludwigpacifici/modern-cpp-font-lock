#pragma once
#define LOG(message) logError(__LINE__, message)

constexpr double pi = 3.14;

thread_local int neat = 1;

[[deprecated]] int *f() noexcept {
  synchronized { printf("transaction"); }
  return nullptr;
};

alignas(128) char cacheline[128];

template <typename... Args>
void print_size(Args... args)
{
  cout << sizeof...(args) << endl;
}

decltype(int) other_integer_variable = 5;

template <class T> concept bool Integral = std::is_integral<T>::value;

struct A final : Base {
  virtual void foo() final;
};
