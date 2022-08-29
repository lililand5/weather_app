# frozen_string_literal: true

module OutputService
  class BinarySearchService
    def search(arr, num, min = 0)
      max = arr.size - 1
      mid = (min + max) / 2

      case num <=> arr[mid]
      when 0
        [arr[mid]]
      when -1
        less(arr, num, mid)
      when 1
        more(arr, num, mid)
      end
    end

    def less(arr, num, mid)
      result = arr.take(mid + 1)
      result.size > 2 ? search(result, num) : result
    end

    def more(arr, num, mid)
      result = arr.drop(mid)
      result.size > 2 ? search(result, num) : result
    end
  end
end
