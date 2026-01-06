- redesign security = 70h
- extrakce servic z core = 70h
- rozsireni funkcionality table akci = 15h
- data table - profily a toolbar = 15h
= 138h
- ma byt 170h

class ActionComponent extends React.Component {
  function render() {
    return (
      <Context.Provider value={getContext()}>
        <Button ...>
          ...
          {additionalRender()}
        </Button>
      </Context.Provider value={getContext()}>
    )
  }

  function additionalRender() { return null }
  function getContext() { return { "some": "basic context" } }
}

class ActionWithModalComponent extends ActionComponent {
  function additionalRender() { return <Modal>...</Modal> }
  function getContext() { return super.getContext() + { "some": "additional context" } }
}
