from functools import wraps
from cache.connection import RedisCache


def fetch_from_cache(cache_name: str, cache_config: dict):
    cache_conn = RedisCache(cache_config['redis'])  # Подключились к Redis
    ttl = cache_config['ttl']

    def wrapper_func(f):
        @wraps(f)
        def wrapper(*args, **kwargs):
            cached_value = cache_conn.get_value(cache_name)  # Извлекаем из кэша
            print('Cached_value = ', cached_value)
            if cached_value:
                return cached_value  # Вовзращаем извлеченное из кэша
            response = f(*args, **kwargs)
            print('Response = ', response)
            cache_conn.set_value(cache_name, response, ttl=ttl)
            return response

        return wrapper

    return wrapper_func
