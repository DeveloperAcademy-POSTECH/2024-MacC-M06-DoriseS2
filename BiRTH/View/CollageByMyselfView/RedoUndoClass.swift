import Foundation

class UndoRedoManager: ObservableObject {
    @Published var currentPastedImages: [PastedImage] = [] // 현재 상태
    private var undoStack: [[PastedImage]] = [] // Undo 스택
    private var redoStack: [[PastedImage]] = [] // Redo 스택
    
    var undoManager: UndoManager?
    
    init(initialState: [PastedImage], undoManager: UndoManager?) {
        self.currentPastedImages = initialState
        self.undoManager = undoManager
    }
    
    // 상태 변경 시 호출
    func updateState(_ newState: [PastedImage]) {
        undoStack.append(currentPastedImages) // 현재 상태를 Undo 스택에 저장
        redoStack.removeAll() // 새로운 작업이 시작되면 Redo 스택 초기화
        currentPastedImages = newState // 새로운 상태로 업데이트
        
        undoManager?.registerUndo(withTarget: self) { target in
            target.undo()
        }
    }
    
    func undo() {
        guard let lastState = undoStack.popLast() else { return }
        redoStack.append(currentPastedImages) // 현재 상태를 Redo 스택에 저장
        currentPastedImages = lastState // Undo 스택에서 상태 복원
    }
    
    func redo() {
        guard let redoState = redoStack.popLast() else { return }
        undoStack.append(currentPastedImages) // 현재 상태를 Undo 스택에 저장
        currentPastedImages = redoState // Redo 스택에서 상태 복원
    }
}
