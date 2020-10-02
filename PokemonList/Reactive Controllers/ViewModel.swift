import Foundation

public enum Result<T> {
    case success(T)
    case failure(Error)
}

public struct ViewModel<T> {
    public typealias ResultType = Result<T>

    private let operation: ( @escaping (ResultType) -> ()) -> ()

    public init(result: ResultType) {
        self.init(operation: { completion in
            completion(result)
        })
    }

    public init(value: T) {
        self.init(result: .success(value))
    }

    public init(error: Error) {
        self.init(result: .failure(error))
    }

    public init(operation: @escaping ( @escaping (ResultType) -> ()) -> ()) {
        self.operation = operation
    }

    fileprivate func then(_ completion: @escaping (ResultType) -> ()) {
        self.operation() { result in
            completion(result)
        }
    }

    public func subscribe(onNext: @escaping (T) -> Void = { _ in }, onError: @escaping (Error) -> Void = { _ in }) {
        self.then { result in
            switch result {
                case .success(let value): onNext(value)
                case .failure(let error): onError(error)
            }
        }
    }
}

extension ViewModel {
    public func map<U>(_ f: @escaping (T) throws -> U) -> ViewModel<U> {
        return ViewModel<U>(operation: { completion in
            self.then { result in
                switch result {

                    case .success(let resultValue):
                        do {
                            let transformedValue = try f(resultValue)
                            completion(Result.success(transformedValue))
                        } catch let error {
                            completion(Result.failure(error))
                        }


                    case .failure(let errorBox):
                        completion(Result.failure(errorBox))

                }
            }
        })
    }

    public func flatMap<U>(_ f: @escaping (T) -> ViewModel<U>) -> ViewModel<U> {
        return ViewModel<U>(operation: { completion in
            self.then { firstFutureResult in
                switch firstFutureResult {
                    case .success(let value): f(value).then(completion)
                    case .failure(let error): completion(Result.failure(error))
                }
            }
        })
    }
}
