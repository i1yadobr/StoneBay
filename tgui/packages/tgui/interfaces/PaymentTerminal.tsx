import { useBackend } from '../backend';
import { Section, Box } from '../components';
import { Window } from '../layouts';

const TerminalButton = (props: {
  children: any;
  onClick: () => void;
  width?: string;
  color?: string;
}) => {
  return (
	<button
	  className="terminal-button"
	  style={{
		width: props.width || '100%',
		backgroundColor: props.color === 'good' ? '#006600' :
						props.color === 'bad' ? '#660000' : '#222222',
	  }}
	  onClick={props.onClick}>
	  {props.children}
	</button>
  );
};

export const PaymentTerminal = (props, context) => {
  const { act, data } = useBackend<PaymentTerminalData>(context);

  const handlePress = (value: string | number) => {
	  act('press', { value });
  };

  const handleSubmit = () => {
	  act('submit');
  };

  const handleClear = () => {
	  act('clear');
  };

  const formatDisplay = (value: string) => {
    if (!value) {
      return <span className="blinking-cursor">_</span>;
    }

    let displayValue = value;
    if (data.mode === 'AMOUNT') {
      displayValue = value.replace(/\B(?=(\d{3})+(?!\d))/g, ' ');
    }

    const chars = displayValue.split('');
    const lastIndex = chars.length - 1;

    return (
      <>
        {chars.map((char, index) => {
          const isLastChar = index === lastIndex;
          if (char === ' ') return ' ';
          return (
            <span
              key={index}
              className={isLastChar ? "char-with-underline" : ""}
            >
              {char}
            </span>
          );
        })}
      </>
    );
  };

  return (
	<Window
	  title="Payment Terminal"
	  width={300}
	  height={405}
	  theme="ntos">
	  <Window.Content>
		<Section
		  title={data.title}
		  className="payment-terminal">
		  <Box className="display" mb={1}
        textAlign={data.mode === 'PIN' ? 'center' : 'right'}>
			{formatDisplay(data.display)}
      {data.mode === 'ACCOUNT' && ' #'}
      {data.mode === 'AMOUNT' && ' C'}
		  </Box>

		  <Box className="status" mb={1}>
			{data.status || 'READY'}
		  </Box>

      <div className="keypad">
        <div className="keypad-row">
          <TerminalButton onClick={() => handlePress(7)}>7</TerminalButton>
          <TerminalButton onClick={() => handlePress(8)}>8</TerminalButton>
          <TerminalButton onClick={() => handlePress(9)}>9</TerminalButton>
        </div>
        <div className="keypad-row">
          <TerminalButton onClick={() => handlePress(4)}>4</TerminalButton>
          <TerminalButton onClick={() => handlePress(5)}>5</TerminalButton>
          <TerminalButton onClick={() => handlePress(6)}>6</TerminalButton>
        </div>
        <div className="keypad-row">
          <TerminalButton onClick={() => handlePress(1)}>1</TerminalButton>
          <TerminalButton onClick={() => handlePress(2)}>2</TerminalButton>
          <TerminalButton onClick={() => handlePress(3)}>3</TerminalButton>
        </div>
        <div className="keypad-row">
          <TerminalButton onClick={handleClear}>C</TerminalButton>
          <TerminalButton onClick={() => handlePress(0)}>0</TerminalButton>
          <TerminalButton color="good" onClick={handleSubmit}>ENTER</TerminalButton>
        </div>
      </div>

		</Section>
	  </Window.Content>
	</Window>
  );
};

interface PaymentTerminalData {
  display: string;
  title: string;
  status: string;
  mode: string;
}
