function message = verifyField(struct,fieldname)
message = '';
if ~isfield(struct,fieldname)
    message = sprintf('Error: structure "%s" is missing field "%s"\\n',inputname(1),fieldname);
end
end