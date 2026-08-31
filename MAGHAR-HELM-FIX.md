# Maghar helmet fix

Race 14 uses the Orc player display models. Its `ChrRaces.ClientPrefix` must therefore also use the Orc prefix `Or`.

The previous `Mo` prefix made the 3.3.5a client resolve race-specific helmet models using non-existent Maghar helmet filenames, which resulted in the blue/white missing-model cube for helmets.

This fix changes only the Maghar `ClientPrefix` from `Mo` to `Or`; `ClientFilestring` remains `Maghar`, so the custom race identity and UI handling are unchanged.
