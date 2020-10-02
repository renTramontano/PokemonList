import UIKit

struct Section {
    let header: ViewNode?
    let cells: [CellNode]?
    let footer: ViewNode?

    init(header: ViewNode? = nil, cells: [CellNode]? = nil, footer: ViewNode? = nil) {
        self.header = header
        self.cells = cells
        self.footer = footer
    }
}

struct CellNode {
    let cell: UIView?
    
    init(_ cell: UIView?) {
        self.cell = cell
    }
}

struct ViewNode {
    let view: UIView?

    init(_ view: UIView?) {
        self.view = view
    }
}
