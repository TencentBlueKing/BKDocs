## 1. 测试隔离

我们的系统内存在各种各样的依赖关系，有自身内部模块之间的依赖，也有对外部环境(运行时组件：MySQL，Redis，Rabbitmq 等)的依赖，这些依赖导致我们在进行测试的时候需要准备各种各样的模块以及环境，增加了我们的测试执行及编写成本，所以，在编写和执行测试时，我们需要进行测试隔离。

一般来说，我们通过提供 Test Double (测试仿件)来实现测试隔离。

### 1.1 与环境隔离

假设我们的待测模块依赖 Redis 组件：

```python
from redis_client import RedisClient

def get_list_from_redis_and_sum(key):
  client = RedisClient()
  
  nums = client.get(key)
  nums = [] if nums is None else nums
  
  return sum(nums)
```

那么我们可以提供 Redis Client 的 Test Double 来实现与环境的隔离

```python
class ClientReturnNone(object):
  def get(key):
    return None

@patch('redis_client.RedisClient', ClientReturnNone)
def test_get_list_from_redis_and_sum__return_none():
  # write your test
  pass
```

### 1.2 与模块隔离

系统中的模块之间会相互协作来完成一些复杂的任务，那么久必定会存在模块间的依赖。如果我们不在测试的时候进行模块的隔离，会导致测试越往上层编写，测试数据准备的成本就越高；另外，加入模块 A 依赖模块 B 及模块 C；既然我们已经完成了模块 B 和模块 C 的独立测试，我们就不需要在测试模块 A 时再次测试模块 B 和 模块 C，只需要保证模块 A 以我们想要的方式完成了调用即可。

**注意，这里的模块指的不是 Python 中的 module，而是一个比较泛的概念，可能是一个 module，一个类或是一个函数。**

假设我们有三个模块 `Waiter`，`House` 及 `Door`，`Waiter` 需要依赖 `House` 和 `Door` 来完成自己的 `serve` 方法：

```python
class Waiter(object):
  def __init__(self, house, door):
    self.house = hosue
    self.door = door

  def serve(self):
    if self.house.peoples > 5:
      self.door.open()

class House(object):
  def __init__(self, peoples):
    self.peoples = peoples

class Door(object):
  def open(self):
    pass
```

那么在编写测试时，可以通过提供 `Waiter` 所依赖模块的 Test Double 来进行隔离：

```python
from mock.mock import MagicMock
from waiter import Waiter

class MockHouse(object):
  def __init__(self, peoples_return):
    self.peoples_return = peoples_return

  def peoples(self):
    return self.peoples_return

class MockDoor(object):
  def __init__(self):
    self.open = MagicMock()

def test_waiter_serve():
  door = MockDoor()
  house = MockHouse(peoples_return=6)
  waiter = Waiter(house=house, door=door)
  
  waiter.serve()
  
  door.open.assert_called_once()
```
